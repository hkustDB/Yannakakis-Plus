create or replace view aggView8823720607094059093 as select id as v12, title as v31 from title as t;
create or replace view aggJoin322011362297728756 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8823720607094059093 where mc.movie_id=aggView8823720607094059093.v12;
create or replace view aggView8331916179582426736 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4648750792913196372 as select v12, v31 from aggJoin322011362297728756 join aggView8331916179582426736 using(v1);
create or replace view aggView315426529697796102 as select v12, MIN(v31) as v31 from aggJoin4648750792913196372 group by v12;
create or replace view aggJoin1975663117091530401 as select keyword_id as v18, v31 from movie_keyword as mk, aggView315426529697796102 where mk.movie_id=aggView315426529697796102.v12;
create or replace view aggView4230882664530972277 as select v18, MIN(v31) as v31 from aggJoin1975663117091530401 group by v18;
create or replace view aggJoin394886125202030831 as select keyword as v9, v31 from keyword as k, aggView4230882664530972277 where k.id=aggView4230882664530972277.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin394886125202030831;
