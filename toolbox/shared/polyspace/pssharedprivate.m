function varargout=pssharedprivate(function_name,varargin)








    [varargout{1:nargout}]=feval(function_name,varargin{1:end});


