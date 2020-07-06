Pod::Spec.new do |s|
  s.name = 'TinySwift'
  s.version = '2.4.1'
  s.summary = 'Powerful Swift classes and structs extensions'
  s.description = 'Powerful Swift classes and structs extensions giving you even better Swift experience.'
  s.homepage = 'https://github.com/sochalewski/TinySwift'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Piotr Sochalewski' => 'sochalewski@gmail.com' }
  s.source = { :git => 'https://github.com/sochalewski/TinySwift.git', :tag => s.version.to_s }
  s.platforms = { :ios => "8.0", :tvos => "9.0", :watchos => "2.0" }
  s.source_files = 'TinySwift/**/*'
  s.swift_versions = ['3.2', '4.0', '4.1', '4.2', '5.0', '5.1', '5.2']
end
