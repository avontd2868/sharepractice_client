class AdminController < ApplicationController

  def index
    @api_key = session[:api_key]
    # all_treatments.each do |t|
    #   name = Disorder.find(t.disorder_cui).name[0]
      #increase o[name['str']]["num"] by 1
    # end
    #make http request and return the response from template: admin view
  end
end

=begin
def cms_index(request):
    tr = loader.get_template('cms_index.html')

    '''o = {}

    for t in Treatment.objects.all():
        name = Disorder(t.disorder_cui).name[0]

        if name['str'] not in o :
            o[name['str']] = { "cui" : name['cui'], "num" : 1 }
        else :
            o[name['str']]["num"] += 1

    return HttpResponse(tr.render( RequestContext(request, { "obj" : o  })))'''
    return HttpResponse(tr.render( RequestContext(request)))
  end
=end