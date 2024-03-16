create or replace view aggView4821846408102765477 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8957787436840871911 as select movie_id as v12 from movie_keyword as mk, aggView4821846408102765477 where mk.keyword_id=aggView4821846408102765477.v18;
create or replace view aggView3634714420700285968 as select v12 from aggJoin8957787436840871911 group by v12;
create or replace view aggJoin8941068836707567505 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView3634714420700285968 where mc.movie_id=aggView3634714420700285968.v12;
create or replace view aggView1841164047210823592 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin7721726621592058930 as select v12 from aggJoin8941068836707567505 join aggView1841164047210823592 using(v1);
create or replace view aggView8381662138069390072 as select v12 from aggJoin7721726621592058930 group by v12;
create or replace view aggJoin3825863857703171661 as select title as v20 from title as t, aggView8381662138069390072 where t.id=aggView8381662138069390072.v12;
select MIN(v20) as v31 from aggJoin3825863857703171661;
