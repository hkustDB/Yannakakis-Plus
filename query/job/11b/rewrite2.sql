create or replace view aggView5740034085990712844 as select id as v17, name as v2 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin8392793761280731457 as (
with aggView759666595842118323 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView759666595842118323 where mk.keyword_id=aggView759666595842118323.v22);
create or replace view aggJoin2673939527384136818 as (
with aggView7630419337809173048 as (select v24 from aggJoin8392793761280731457 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView7630419337809173048 where t.id=aggView7630419337809173048.v24 and title LIKE '%Money%' and production_year= 1998);
create or replace view aggView9103232449062016268 as select v28, v24 from aggJoin2673939527384136818 group by v28,v24;
create or replace view aggJoin9007730316472901412 as (
with aggView1939929451589758169 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView1939929451589758169 where ml.link_type_id=aggView1939929451589758169.v13);
create or replace view aggJoin1309153272214048921 as (
with aggView5283866133843304390 as (select v24, MIN(v40) as v40 from aggJoin9007730316472901412 group by v24,v40)
select v28, v24, v40 from aggView9103232449062016268 join aggView5283866133843304390 using(v24));
create or replace view aggJoin6392689438921799718 as (
with aggView5500358755768336654 as (select v24, MIN(v40) as v40, MIN(v28) as v41 from aggJoin1309153272214048921 group by v24,v40)
select company_id as v17, company_type_id as v18, v40, v41 from movie_companies as mc, aggView5500358755768336654 where mc.movie_id=aggView5500358755768336654.v24);
create or replace view aggJoin1904020145119090170 as (
with aggView1335606574522139138 as (select id as v18 from company_type as ct where kind= 'production companies')
select v17, v40, v41 from aggJoin6392689438921799718 join aggView1335606574522139138 using(v18));
create or replace view aggJoin7524109264535075072 as (
with aggView3119089484318945681 as (select v17, MIN(v40) as v40, MIN(v41) as v41 from aggJoin1904020145119090170 group by v17,v40,v41)
select v2, v40, v41 from aggView5740034085990712844 join aggView3119089484318945681 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin7524109264535075072;
