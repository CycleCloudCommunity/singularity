Singularity
========

This project installs `Singularity <http://singularity.lbl.gov/index.html>`_
within a CentOS or Ubuntu environment


Pre-Requisites
--------------

This sample requires the following:

  1. CycleCloud must be installed and running.

     a. If this is not the case, see the CycleCloud QuickStart Guide for
        assistance.

  2. The CycleCloud CLI must be installed and configured for use.

  3. You must have access to log in to CycleCloud.

  4. You must have access to upload data and launch instances in your chosen
     Cloud Provider account.

  5. You must have access to a configured CycleCloud "Locker" for Project Storage
     (Cluster-Init and Chef).

  6. Optional: To use the `cyclecloud project upload <locker>` command, you must
     have a Pogo configuration file set up with write-access to your locker.

     a. You may use your preferred tool to interact with your storage "Locker"
        instead.

  7. Centos 7 and Ubuntu 16 with Cyclecloud 6.5.7 has been tested and confirmed working.

  8. To get project dependencies, run `sh setup.sh`


**NOTE:**
::

  The instructions in this guide assume the use of Amazon Web Services for the Cloud Provider account.


Usage
=====

A. Configuring the Project
--------------------------

The first step is to configure the project for use with your storage locker:

  1. Open a terminal session with the CycleCloud CLI enabled.

  2. Switch to the singularity directory.

  3. Run ``cyclecloud project add_target my_locker`` (assuming the locker is named "my_locker").
     The locker name will generally be the same as the cloud provider you created when configuring
     CycleCloud. The expected output looks like this:::

       $ cyclecloud project add_target my_locker
       Name: singularity
       Version: 1.0.0
       Targets:
          my_locker: {'default': 'true', 'is_locker': 'true'}

     NOTE: You may call add_target as many times as needed to add additional target lockers.


B. Deploying the Project
------------------------

To upload the project (including any local changes) to your target locker, run the
`cyclecloud project upload` command from the project directory.  The expected output looks like
this:::

    $ cyclecloud project upload
    Sync completed!

*IMPORTANT*

For the upload to succeed, you must have a valid Pogo configuration for your target Locker.


C. Importing the Cluster Template
---------------------------------

To import the cluster:

  1. Open a terminal session with the CycleCloud CLI enabled.

  2. Switch to the singularity directory.

  3. Run ``cyclecloud import_cluster singularity -f templates/singularity.txt``.
     The expected output looks like this:::

       $ cyclecloud import_cluster NAME -f templates/machinelearning.txt
       Importing cluster NAME....
       ----------------------
       NAME : *template*
       ----------------------
       Keypair: $keypair
       Cluster nodes:
           master: off
       Total nodes: 1



D. Starting and Stopping the Cluster
------------------------------------------

  1. Select the newly created cluster from the **Clusters**
     frame on the CycleCloud "Clusters" page

  2. To start the cluster, click the **Start** link in the cluster status
     frame.

  3. Later, to stop a started cluster, click the **Terminate** link in the
     cluster status frame.

F. Testing the Cluster
----------------------------


1. Start the cluster and log in to ``master``.
::

    $ cyclecloud connect master -c singularity


2. Create a simple singularity container based on a Centos 7 docker image
::

    $ singularity pull docker://centos:7

3. Start a shell in the container
::

    $ singularity shell centos-7.img
