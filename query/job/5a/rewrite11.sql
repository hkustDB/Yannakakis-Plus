create or replace view aggView6052530039720117775 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin5967698670715760668 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView6052530039720117775 where mi.movie_id=aggView6052530039720117775.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView154615430163576898 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin9046549702229437636 as select movie_id as v15, note as v9 from movie_companies as mc, aggView154615430163576898 where mc.company_type_id=aggView154615430163576898.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6181640644276514444 as select v15 from aggJoin9046549702229437636 group by v15;
create or replace view aggJoin9040784741599093606 as select v3, v13, v27 as v27 from aggJoin5967698670715760668 join aggView6181640644276514444 using(v15);
create or replace view aggView5690757720032713359 as select v3, MIN(v27) as v27 from aggJoin9040784741599093606 group by v3;
create or replace view aggJoin7380566169417098758 as select v27 from info_type as it, aggView5690757720032713359 where it.id=aggView5690757720032713359.v3;
select MIN(v27) as v27 from aggJoin7380566169417098758;
