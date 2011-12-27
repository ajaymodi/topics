package org.krams.tutorial.service;

import java.util.*;

import com.mongodb.DBObject;

public interface IUserService {

	/**
	 * Retrieves all users
	 */
	public List<DBObject> getAll();

	/**
	 * Retrieves a single user based on id
	 */
	public DBObject get(String id);

	/**
	 * Add a new user
	 */
	public Boolean add(String userName, ArrayList categories, ArrayList like );

	/**
	 * Delete an existing user
	 */
	public Boolean delete(String id);

	/**
	 * Edit an existing user
	 */
	public Boolean edit(String id, String userName, ArrayList categories,ArrayList like);

}