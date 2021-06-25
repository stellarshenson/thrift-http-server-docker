echo "starting thriftserver with hhtp endpoint, connecting to $SPARK_MASTER and $HIVE_SITE_CONF_hive_metastore_uris"
/spark/sbin/start-thriftserver.sh --master $SPARK_MASTER
tail -f /dev/null
