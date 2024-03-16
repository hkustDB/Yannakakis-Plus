create or replace view aggView97870060085103358 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin2538432550431671373 as select movie_id as v12 from movie_companies as mc, aggView97870060085103358 where mc.company_id=aggView97870060085103358.v1;
create or replace view aggView1323294219781221933 as select v12 from aggJoin2538432550431671373 group by v12;
create or replace view aggJoin4947926934781227021 as select id as v12, title as v20 from title as t, aggView1323294219781221933 where t.id=aggView1323294219781221933.v12;
create or replace view aggView4546709493353166292 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1251240785180630486 as select movie_id as v12 from movie_keyword as mk, aggView4546709493353166292 where mk.keyword_id=aggView4546709493353166292.v18;
create or replace view aggView8309541851931926373 as select v12 from aggJoin1251240785180630486 group by v12;
create or replace view aggJoin9175357479123681082 as select v20 from aggJoin4947926934781227021 join aggView8309541851931926373 using(v12);
select MIN(v20) as v31 from aggJoin9175357479123681082;
