  seed =  -1
  seqfile = genes.phy
  Imapfile = Asimina.Imap.txt
  jobname = genus 

  speciesdelimitation = 0 * fixed species tree
  speciestree = 0 * speciestree pSlider ExpandRatio ShrinkRatio

  speciesmodelprior = 1  * 0: uniform LH; 1:uniform rooted trees; 2: uniformSLH; 3: uniformSRooted
                
  species&tree = 13  Annona_glabra  Annona_scandens  Asimina_incana  Asimina_longifolia  Asimina_obovata  Asimina_parviflora  Asimina_reticulata  Asimina_tetramera  Asimina_triloba  Deeringothamnus_pulchellus  Deeringothamnus_rugelii  Diclinanona_calycina  Goniothalamus_laoticus
                    1  1  3  3  5  7  7  2  7  3  3  1  1
                    (((((((((Asimina_longifolia,Asimina_obovata),(Deeringothamnus_rugelii,Deeringothamnus_pulchellus)),(Asimina_reticulata,Asimina_tetramera)),Asimina_incana),Asimina_parviflora),Asimina_triloba),Diclinanona_calycina),(Annona_glabra,Annona_scandens)),Goniothalamus_laoticus);

  phase =   1  1  1  1	1  1  1  1  1  1  1  1  1
  usedata = 1  * 0: no data (prior); 1:seq like
  nloci = 30  * number of data sets in seqfile

  model = GTR
  
  alphaprior = 1 1 4
  thetamodel = linked-inner

  cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

  thetaprior = invgamma 3 0.002 e # gamma(a, b) for theta (estimate theta)
  tauprior = gamma 0.1 10 # gamma(a, b) for root tau & Dirichlet(a) for other tau's

  finetune = 1 Gage:5 Gspr:0.001 mix:0.3  # finetune for GBtj, GBspr, theta, tau, mix, locusrate, seqerr
  locusrate = 1 10.0 10.0 5.0 iid
  clock = 2 10.0 100.0 5.0 iid G

  print = 1 0 0 0   * MCMC samples, locusrate, heredityscalars, Genetrees
  burnin = 200000
  sampfreq = 10
  nsample = 200000
  threads = 30
