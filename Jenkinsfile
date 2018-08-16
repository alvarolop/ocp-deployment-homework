node {
    stage ("Build")
        echo '*** Build Starting ***'
        openshiftBuild bldCfg: 'tasks', buildName: '', checkForTriggeredDeployments: 'false', commitID: '', namespace: '', showBuildLogs: 'true', verbose: 'true'
        openshiftVerifyBuild bldCfg: 'tasks', checkForTriggeredDeployments: 'false', namespace: '', verbose: 'false'
        echo '*** Build Complete ***'
    stage ("Deploy and Verify in Development Env")
        echo '*** Deployment Starting ***'
        openshiftDeploy depCfg: 'tasks', namespace: '', verbose: 'false', waitTime: ''
        openshiftVerifyDeployment authToken: '', depCfg: 'tasks', namespace: '', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
        echo '*** Deployment Complete ***'
    stage ("Build")
        echo '*** Build Starting ***'
        openshiftBuild bldCfg: 'tasks', buildName: '', checkForTriggeredDeployments: 'false', commitID: '', namespace: '', showBuildLogs: 'false', verbose: 'false', waitTime: ''
        openshiftVerifyBuild apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', bldCfg: 'tasks', checkForTriggeredDeployments: 'false', namespace: '', verbose: 'false'
        echo '*** Build Complete ***'

    stage ("Deploy and Verify in Development Env")
        echo '*** Deployment Starting ***'
        openshiftDeploy apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', depCfg: 'tasks', namespace: '', verbose: 'false', waitTime: ''
        openshiftVerifyDeployment apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', depCfg: 'tasks', namespace: '', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: ''
        echo '*** Deployment Complete ***'

    echo '*** Service Verification Starting ***'
        openshiftVerifyService apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', namespace: 'pipeline-dev', svcName: 'tasks', verbose: 'false'
        echo '*** Service Verification Complete ***'
        openshiftTag(srcStream: 'tasks', srcTag: 'latest', destStream: 'tasks', destTag: 'testready')

    stage ('Deploy and Test in Testing Env')
        echo '*** Deploy testready build in pipeline-test project  ***'
        openshiftDeploy apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', depCfg: 'tasks', namespace: 'pipeline-test', verbose: 'false', waitTime: ''

        openshiftVerifyDeployment apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', depCfg: 'tasks', namespace: 'pipeline-test', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: '10'
        sh 'curl http://tasks-pipeline-test.apps.na39.openshift.opentlc.com/data/ | grep cats -q'

    stage ('Promote and Verify in Production Env')
        echo '*** Waiting for Input ***'
        input 'Should we deploy to Production?'
        openshiftTag(srcStream: 'tasks', srcTag: 'testready', destStream: 'tasks', destTag: 'prodready')
        echo '*** Deploying to Production ***'
        openshiftDeploy apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', depCfg: 'tasks', namespace: 'pipeline-prod', verbose: 'false', waitTime: ''
        openshiftVerifyDeployment apiURL: 'https://openshift.default.svc.cluster.local', authToken: '', depCfg: 'tasks', namespace: 'pipeline-prod', replicaCount: '1', verbose: 'false', verifyReplicaCount: 'false', waitTime: '10'
        sleep 10
        sh 'curl http://tasks-pipeline-prod.apps.na.openshift.opentlc.com/data/ | grep cats -q'
  }
