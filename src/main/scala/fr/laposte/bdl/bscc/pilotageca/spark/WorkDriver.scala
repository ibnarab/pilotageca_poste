package fr.laposte.bdl.bscc.pilotageca.spark

import fr.laposte.bdl.bscc.pilotageca.common.AppConfig
import fr.laposte.bdl.bscc.utlv4scala.UtlLogging
import org.apache.spark.sql.SparkSession
import org.slf4j.{Logger, LoggerFactory}


/** Classe qui centralise les traitements du DRIVER.
  *
  */
object WorkDriver {

  // le logger de la classe
  val logger : Logger = LoggerFactory.getLogger(getClass.getCanonicalName)

  // chargement de la conf
  AppConfig.load()

  // affichage de la conf
  AppConfig.logInfo(logger)


  /** Traitements a effectuer par le driver.
    *
    * @param spark Session spark.
    *
    */
  def doit(spark : SparkSession) : Unit = {

    // affichage cle de parametrage "cle"
    UtlLogging.debug(logger, Array("debug/app.cle=" + AppConfig.getCle))
    UtlLogging.info(logger, Array("info/app.cle=" + AppConfig.getCle))


    // affichage des bases de donnees
    spark.sql("SHOW DATABASES").show(truncate = false)


    // creation RDD
    val seq = Seq((1, "AA"), (2, "BB"), (3, "CC"), (4, "DD"), (5, "EE"), (6, "FF"), (7, "GG"), (8, "HH"), (9, "II"))

    UtlLogging.info(logger, Array(s"Creation RDD de 9 lignes sur 5 partitions", s"seq=$seq"))

    val rdd = spark.sparkContext.parallelize(seq, 5)


    // parcours des partitions
    UtlLogging.info(logger, Array(s"DEBUT PARCOURS DES PARTITIONS"))

    rdd.foreachPartition(WorkExecutor.doitPartition)

    UtlLogging.info(logger, Array(s"FIN PARCOURS DES PARTITIONS"))

  }

}
