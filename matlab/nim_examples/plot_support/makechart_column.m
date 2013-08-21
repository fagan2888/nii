%same as makechart, but arranges panels over one column
function makechart(titlelist,legendlist,figlabel,ylabels,zdata1,zdata2,zdata3)



figure

titlelist = char(strrep(cellstr(titlelist),'_','.'));

ndsets=3;       % default, changed below as applicable
if nargin==5
    zdata2=nan*zdata1;
    zdata3=nan*zdata1;
    ndsets =1;
elseif nargin == 6
    zdata3 =nan*zdata1;
    ndsets=2;
elseif ((nargin>8) | (nargin <=4))
    error ('makechart takes 5 to 6 arguments')
end

nobs = size(zdata1,1);
xvalues = (1:nobs)';

nvars = size(titlelist,1);
nrows=nvars;
ncols = 1;

for i = 1:nvars
    subplot(nrows,ncols,i)
    h1=plot(xvalues,zdata1(:,i),'k-',xvalues,zdata2(:,i),'r--',xvalues,zdata3(:,i),'b:');
    [x0 x1 y10 y11] = pickaxes(xvalues,zdata1(:,i));
    [x0 x1 y20 y21] = pickaxes(xvalues,zdata2(:,i));
    [x0 x1 y30 y31] = pickaxes(xvalues,zdata3(:,i));
    y0 = min([y10,y20,y30]);
    y1 = max([y11,y21,y31]);
    if y0==y1
        y1=y0+1;
    end
    
    axis([x0 x1 y0 y1])
    set(h1,'linewidth',2);

    if i==1
        legend(legendlist)
        text('String',figlabel,'Units','normalized','Position',[1.2 1.24],...
       'FontSize',14,'FontWeight','bold','HorizontalAlignment','center');
    end
 
    if i==nvars | i==nvars-1
        xlabel('Quarters');
    end
%     set(gca,'XTick',xtick)
%     set(gca,'XTickLabel',xticklabel)
    
    title([num2str(i),'. ',titlelist(i,:)]);
    ylabel(ylabels(i,:))
end

% sets printing preferences
printpref
