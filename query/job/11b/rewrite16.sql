create or replace view aggJoin4571606476743314898 as (
with aggView7406524362473068507 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v24, company_type_id as v18, v39 from movie_companies as mc, aggView7406524362473068507 where mc.company_id=aggView7406524362473068507.v17);
create or replace view aggJoin7427643193844766374 as (
with aggView8226269063408214102 as (select id as v24, title as v41 from title as t where title LIKE '%Money%' and production_year= 1998)
select v24, v18, v39, v41 from aggJoin4571606476743314898 join aggView8226269063408214102 using(v24));
create or replace view aggJoin6410504293410648336 as (
with aggView5692876336088701296 as (select id as v13, link as v40 from link_type as lt where link LIKE '%follows%')
select movie_id as v24, v40 from movie_link as ml, aggView5692876336088701296 where ml.link_type_id=aggView5692876336088701296.v13);
create or replace view aggJoin9146246329227746852 as (
with aggView7903632468308847601 as (select id as v22 from keyword as k where keyword= 'sequel')
select movie_id as v24 from movie_keyword as mk, aggView7903632468308847601 where mk.keyword_id=aggView7903632468308847601.v22);
create or replace view aggJoin5118441901528150094 as (
with aggView4681457350494366728 as (select id as v18 from company_type as ct where kind= 'production companies')
select v24, v39, v41 from aggJoin7427643193844766374 join aggView4681457350494366728 using(v18));
create or replace view aggJoin3166334814393183376 as (
with aggView4807873473379586922 as (select v24, MIN(v39) as v39, MIN(v41) as v41 from aggJoin5118441901528150094 group by v24,v39,v41)
select v24, v40 as v40, v39, v41 from aggJoin6410504293410648336 join aggView4807873473379586922 using(v24));
create or replace view aggJoin4345031573970914308 as (
with aggView1529624540525962819 as (select v24, MIN(v40) as v40, MIN(v39) as v39, MIN(v41) as v41 from aggJoin3166334814393183376 group by v24,v39,v40,v41)
select v40, v39, v41 from aggJoin9146246329227746852 join aggView1529624540525962819 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin4345031573970914308;
