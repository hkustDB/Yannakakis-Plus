create or replace view aggView970498855440566037 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin2235670323708231444 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView970498855440566037 where mc.movie_id=aggView970498855440566037.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6782884175690682441 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8178662898273095905 as select v15, v9, v28, v29 from aggJoin2235670323708231444 join aggView6782884175690682441 using(v1);
create or replace view aggView8931888952687989696 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin8178662898273095905 group by v15;
create or replace view aggJoin3770819614249624108 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView8931888952687989696 where mi_idx.movie_id=aggView8931888952687989696.v15;
create or replace view aggView4135376124696296715 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1578652027279367887 as select v28, v29, v27 from aggJoin3770819614249624108 join aggView4135376124696296715 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1578652027279367887;
