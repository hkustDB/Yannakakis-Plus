create or replace view aggView6783178593953629106 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin3394313306694744361 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6783178593953629106 where mi.movie_id=aggView6783178593953629106.v12 and info= 'Bulgaria';
create or replace view aggView5538556911729973922 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3070339733418026025 as select movie_id as v12 from movie_keyword as mk, aggView5538556911729973922 where mk.keyword_id=aggView5538556911729973922.v1;
create or replace view aggView2613039504934225055 as select v12 from aggJoin3070339733418026025 group by v12;
create or replace view aggJoin8148076666649341832 as select v24 as v24 from aggJoin3394313306694744361 join aggView2613039504934225055 using(v12);
select MIN(v24) as v24 from aggJoin8148076666649341832;
