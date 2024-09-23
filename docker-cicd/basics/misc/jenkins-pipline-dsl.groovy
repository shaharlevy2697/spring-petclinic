pipelineJob('DSL_Pipeline') {

  def repo = 'https://github.com/shaharlevy2697/docker-cicd/'

  triggers {
    scm('H/5 * * * *')
  }
  description("Pipeline for $repo")

  definition {
    cpsScm {
      scm {
        git {
          remote { url(repo) }
          branches('master', '**/feature*')
          scriptPath('misc/jenkinsfile')
          extensions { }  // required as otherwise it may try to tag the repo, which you may not want
        }
      }
    }
  }
}
