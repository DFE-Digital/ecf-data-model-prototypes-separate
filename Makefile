psql_command=psql -q

refresh:
	${psql_command} < ./build/recreate-database.sql
	${psql_command} normalised_ecf_data_prototype < ./build/setup.sql
