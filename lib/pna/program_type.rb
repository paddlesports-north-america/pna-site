class Pna::ProgramType
  OTHER = 'other'
  LEADERSHIP = 'leadership'
  COACHING = 'coaching'
  MODULE = 'module'
  PROVIDER = 'provider'
  PERFORMANCE = 'performance'
  TRAINING = 'training'
  ENDORSEMENT = 'endorsement'
  LEGACY = 'legacy'
  
  ALL = [ PERFORMANCE, LEADERSHIP, COACHING, MODULE, PROVIDER, ENDORSEMENT, TRAINING, LEGACY, OTHER ]

  SHOW_ON_COACHES_PAGE = [ COACHING, LEGACY, ENDORSEMENT, PROVIDER ]
end
