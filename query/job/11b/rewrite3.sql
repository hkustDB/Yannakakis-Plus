create or replace view aggJoin7056379962673048558 as (
with aggView1022447596673384797 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView1022447596673384797 where mc.company_id=aggView1022447596673384797.v17);
create or replace view aggJoin5257129999484861503 as (
with aggView7554911621837003269 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView7554911621837003269 where ml.link_type_id=aggView7554911621837003269.v13);
create or replace view aggJoin7117406112921423570 as (
with aggView5042906585711708689 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView5042906585711708689 where mk.keyword_id=aggView5042906585711708689.v22);
create or replace view aggJoin2105990900966543627 as (
with aggView5930789539407721208 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39 from aggJoin7056379962673048558 join aggView5930789539407721208 using(v18));
create or replace view aggJoin6994709603339058646 as (
with aggView7628715954804435621 as (select v24, MIN(v39) as v39 from aggJoin2105990900966543627 group by v24,v39)
select v24, v40 as v40, v39 from aggJoin5257129999484861503 join aggView7628715954804435621 using(v24));
create or replace view aggJoin7881109883639257323 as (
with aggView3283489175574374902 as (select v24, MIN(v40) as v40, MIN(v39) as v39 from aggJoin6994709603339058646 group by v24,v39,v40)
select id as v24, title as v28, production_year as v31, v40, v39 from title as t, aggView3283489175574374902 where t.id=aggView3283489175574374902.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggJoin1682330931877691530 as (
with aggView692118123537938368 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v28) as v41 from aggJoin7881109883639257323 group by v24,v39,v40)
select v40, v39, v41 from aggJoin7117406112921423570 join aggView692118123537938368 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin1682330931877691530;
