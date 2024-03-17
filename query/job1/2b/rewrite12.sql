create or replace view aggView6905422188038281525 as select id as v12, title as v31 from title as t;
create or replace view aggJoin566379406425490569 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6905422188038281525 where mc.movie_id=aggView6905422188038281525.v12;
create or replace view aggView3861694123561007662 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4385348114521612688 as select movie_id as v12 from movie_keyword as mk, aggView3861694123561007662 where mk.keyword_id=aggView3861694123561007662.v18;
create or replace view aggView4062533945235436062 as select v12 from aggJoin4385348114521612688 group by v12;
create or replace view aggJoin5665223832852523675 as select v1, v31 as v31 from aggJoin566379406425490569 join aggView4062533945235436062 using(v12);
create or replace view aggView1022122337765559127 as select v1, MIN(v31) as v31 from aggJoin5665223832852523675 group by v1;
create or replace view aggJoin5043114821591520667 as select country_code as v3, v31 from company_name as cn, aggView1022122337765559127 where cn.id=aggView1022122337765559127.v1 and country_code= '[nl]';
select MIN(v31) as v31 from aggJoin5043114821591520667;
