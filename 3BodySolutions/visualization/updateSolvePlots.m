function updateSolvePlots( zarray,plots )

plots{1}.XData = zarray(end,1);
plots{1}.YData = zarray(end,2);
plots{2}.XData = zarray(:,1);
plots{2}.YData = zarray(:,2);

plots{3}.XData = zarray(end,3);
plots{3}.YData = zarray(end,4);
plots{4}.XData = zarray(:,3);
plots{4}.YData = zarray(:,4);

plots{5}.XData = zarray(end,5);
plots{5}.YData = zarray(end,6);
plots{6}.XData = zarray(:,5);
plots{6}.YData = zarray(:,6);

drawnow;

end

