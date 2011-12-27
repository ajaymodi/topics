/**
 * 
 */
package org.krams.tutorial.controller;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.krams.tutorial.json.CustomGenericResponse;
import org.krams.tutorial.json.CustomUserResponse;
import org.krams.tutorial.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBObject;

/**
 * Handles CRUD requests for users
 * 
 */
@Controller
@RequestMapping("/crud")
public class UserController {
	
		protected static Logger logger = Logger.getLogger("controller");
	
	 	@Resource(name="userService")
	 	private IUserService userService;

	 	/**
	 	 * The default method when a request to /users is made.
	 	 * This essentially retrieves all users, which are wrapped inside a CustomUserResponse object.
	 	 * The object is automatically converted to JSON when returning back the response.
	 	 * The @ResponseBody is responsible for this behavior.
	 	 */
        @RequestMapping(method = RequestMethod.GET)
        public @ResponseBody  CustomUserResponse getAll(
        ) {
        	logger.debug("Received request to get all users");

        	// Retrieve all users from the service
        	List<DBObject> users = userService.getAll();
        	
        	// Initialize our custom user response wrapper
        	CustomUserResponse response = new CustomUserResponse();
        	
        	// Assign the result from the service to this response
        	response.setRows(users);

        	// Assign the total number of records found. This is used for paging
        	response.setRecords( String.valueOf(users.size()) );
        	
        	// Since our service is just a simple service for teaching purposes
        	// We didn't really do any paging. But normally your DAOs or your persistence layer should support this
        	// Assign a dummy page
        	response.setPage( "1" );
        	
        	// Same. Assign a dummy total pages
        	response.setTotal( "10" );
        	
        	// Return the response
        	// Spring will automatically convert our CustomUserResponse as JSON object. 
        	// This is triggered by the @ResponseBody annotation. 
        	// It knows this because the JqGrid has set the headers to accept JSON format when it made a request
        	// Spring by default uses Jackson to convert the object to JSON
        	return response;
    	}
        
        /**
         * Edit the current user.
         */
        @RequestMapping(value = "/edit", method = RequestMethod.POST)
        public @ResponseBody CustomGenericResponse edit(
        		@RequestParam("id") String id,
        		@RequestParam("userName") String userName,
        		@RequestParam("categories") ArrayList categories,
                        @RequestParam("like") ArrayList like

        ) {
        	logger.debug("Received request to edit user");

        	// Edit existing user by delegating to UserService
        	Boolean success = userService.edit( id, userName, categories, like);
        	
        	// Check if successful
        	if ( success == true ) {
        		// Success. Return a custom response
        		CustomGenericResponse response = new CustomGenericResponse();
    			response.setSuccess(true);
    			response.setMessage("Action successful!");
        		return response;
        		
        	} else {
        		// A failure. Return a custom response as well
        		CustomGenericResponse response = new CustomGenericResponse();
    			response.setSuccess(false);
    			response.setMessage("Action failure!");
        		return response;
        	}
	
    	}
        
        /**
         * Add a new user
         */
        @RequestMapping(value = "/add", method = RequestMethod.POST)
        public @ResponseBody CustomGenericResponse add(
        		@RequestParam("userName") String userName,
        		@RequestParam("categories") ArrayList categories,
                        @RequestParam("like") ArrayList like
        ) {
        	logger.debug("Received request to add a new user");
        	
        	// Add a new user by delegating to the UserService
        	Boolean success = userService.add(userName, categories, like);
        	
        	// Check if successful
        	if ( success == true ) {
        		// Success. Return a custom response
        		CustomGenericResponse response = new CustomGenericResponse();
    			response.setSuccess(true);
    			response.setMessage("Action successful!");
        		return response;
        		
        	} else {
        		// A failure. Return a custom response as well
        		CustomGenericResponse response = new CustomGenericResponse();
    			response.setSuccess(false);
    			response.setMessage("Action failure!");
        		return response;
        	}
        	
    	}
        
        /**
         * Delete an existing user
         */
        @RequestMapping(value = "/delete", method = RequestMethod.POST)
        public @ResponseBody CustomGenericResponse delete(
        		@RequestParam("id") String id
        ) {
        	
        	logger.debug("Received request to delete an existing user");
        	
        	// Delete existing user by delegating to the UserService
        	Boolean success = userService.delete(id);
        	
        	// Check if successful
        	if ( success == true ) {
        		// Success. Return a custom response
        		CustomGenericResponse response = new CustomGenericResponse();
    			response.setSuccess(true);
    			response.setMessage("Action successful!");
        		return response;
        		
        	} else {
        		// A failure. Return a custom response as well
        		CustomGenericResponse response = new CustomGenericResponse();
    			response.setSuccess(false);
    			response.setMessage("Action failure!");
        		return response;
        	}
    	}
        
}