from distutils.core import setup
setup(
  name = 'SafeML',         
  packages = ['SafeML'],   
  version = '0.2',     
  license='MIT',       
  description = 'Model-agnostic safety monitoring of machine learning algorithms',
  author = 'Koorosh Aslansefat',               
  author_email = 'k.aslansefat@hull.ac.uk',     
  url = 'https://github.com/ISorokos/SafeML',   
  download_url = 'https://github.com/ISorokos/SafeML/archive/v1.2.tar.gz',   
  keywords = ['aisafety', 'safety', 'trustworthyai'], 
  install_requires=[            # I get to this in a second
          'numpy',
          'spm1d',
      ],
  classifiers=[
    'Development Status :: 3 - Alpha',      
    'Intended Audience :: Developers',     
    'Topic :: Software Development :: Build Tools',
    'License :: OSI Approved :: MIT License',  
    'Programming Language :: Python :: 3',      
    'Programming Language :: Python :: 3.4',
    'Programming Language :: Python :: 3.5',
    'Programming Language :: Python :: 3.6',
    'Programming Language :: Python :: 3.7',
    'Programming Language :: Python :: 3.8',
    'Programming Language :: Python :: 3.6',
    'Programming Language :: Python :: 3.10',
  ],
)
