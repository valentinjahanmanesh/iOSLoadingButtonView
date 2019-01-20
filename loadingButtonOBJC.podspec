Pod::Spec.new do |s|
  s.name             = 'loadingButtonOBJC'
  s.version          = '0.1.0'
  s.summary          = 'this button can have multiple style, showing a loading to your users while app is doing something in background.'
  s.description      = <<-DESC
  you can use this button to show loading while your app is doing something in background, it has 4 styles of loading and all of them are fully customizable.'                      
						  DESC
  s.homepage         = 'https://github.com/farshadjahanmanesh/iOSLoadingButtonView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'farshad jahanmanesh' => 'farshadjahanmanesh@gmail.com' }
  s.source           = { :git => 'https://github.com/farshadjahanmanesh/iOSLoadingButtonView.git' }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'loadingButton/LBVLoadingButtonView/*.{h,m}'
 
end