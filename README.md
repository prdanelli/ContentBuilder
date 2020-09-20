# Rails Content Builder

A first attempt at a content builder of Rails


## Structure

Post
	- Title
	|
	(has many)
	- Blocks
		- Type
			- Text
			- Textarea
			- Trix
			- Image
			- Gallery
		- Content
		- Position
		-

## Changing Rails configuration

Install Yarn packages:

```bash
docker-compose exec rails yarn add <package_name>
```


If you wish to make changes to Rails configuration files, use:

```bash
docker-compose stop rails
docker-compose start rails
```

This will bring the container up in the background with the new configuration.

## Executing commands

To execute a command on a running container, use the following command:

```bash
# docker-compose exec <container_name> <command>
docker-compose exec rails rails db:migrate
```
