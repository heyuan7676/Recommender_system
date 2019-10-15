function [U,V,d]=matrix_factor(input,method,lambdau,lambdav)
omega=double(input>0);
d=5;
%lambdav = 5;
%lambdau = 5;
switch(method)
    case 'sgd'
        fprintf('sgd\n');
        error('not implemented yet');
    case 'als'
        fprintf('als\n');
        U=rand(d,size(input,1));
        V=rand(d,size(input,2));
        converge=false;
        old_L=inf;
        while ~converge
            for j=1:size(input,2)
                sth=zeros(d,d);
                for i=1:size(input,1)
                    sth=sth+omega(i,j)*(U(:,i)*U(:,i)');
                end
                V(:,j)=(lambdav*eye(d)+sth)\U*input(:,j);
            end
            for i=1:size(input,1)
                sth=zeros(d,d);
                for j=1:size(input,2)
                    sth=sth+omega(i,j)*(V(:,j)*V(:,j)');
                end
                U(:,i)=(lambdau*eye(d)+sth)\V*input(i,:)';
            end
            L=sum(sum(((U'*V).*omega-input).^2))+lambdau*sum(sum(U.^2))+lambdav*sum(sum(V.^2));
            if (old_L-L)<L*0.05
                converge=true;
            end
            old_L=L;
            L
%            loss=sqrt(sum(sum(((U'*V).*omega-input).^2))/sum(sum(omega)));
%            fprintf('%f::%f\n',L,loss);
%            sqrt(sum(sum(((U'*V).*omega_test-test_data).^2))/sum(sum(omega_test)))
        end
    otherwise
        error('unknown method');
end
