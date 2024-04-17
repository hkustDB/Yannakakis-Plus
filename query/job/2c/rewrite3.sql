create or replace view aggView7380425147277223958 as select id as v12, title as v31 from title as t;
create or replace view aggJoin2160909004942826981 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView7380425147277223958 where mc.movie_id=aggView7380425147277223958.v12;
create or replace view aggView6998990024807620043 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin8071487729827830547 as select v12, v31 from aggJoin2160909004942826981 join aggView6998990024807620043 using(v1);
create or replace view aggView4883612136040376201 as select v12, MIN(v31) as v31 from aggJoin8071487729827830547 group by v12,v31;
create or replace view aggJoin3993182581429577059 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4883612136040376201 where mk.movie_id=aggView4883612136040376201.v12;
create or replace view aggView275217951674857970 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6338765856377432412 as select v31 from aggJoin3993182581429577059 join aggView275217951674857970 using(v18);
select MIN(v31) as v31 from aggJoin6338765856377432412;
