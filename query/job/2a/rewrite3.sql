create or replace view aggView1323206278135009438 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3179515380420586006 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView1323206278135009438 where mc.movie_id=aggView1323206278135009438.v12;
create or replace view aggView7175870914911067730 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4159242040849490323 as select v12, v31 from aggJoin3179515380420586006 join aggView7175870914911067730 using(v1);
create or replace view aggView301242248740308626 as select v12, MIN(v31) as v31 from aggJoin4159242040849490323 group by v12,v31;
create or replace view aggJoin5845876891605204481 as select keyword_id as v18, v31 from movie_keyword as mk, aggView301242248740308626 where mk.movie_id=aggView301242248740308626.v12;
create or replace view aggView2804733620182827108 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7909939215253458285 as select v31 from aggJoin5845876891605204481 join aggView2804733620182827108 using(v18);
select MIN(v31) as v31 from aggJoin7909939215253458285;
