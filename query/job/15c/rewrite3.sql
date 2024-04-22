create or replace view aggJoin4509346483149489820 as (
with aggView9054860152175706024 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView9054860152175706024 where mc.company_id=aggView9054860152175706024.v13);
create or replace view aggJoin9134558330641578811 as (
with aggView4936415334518579789 as (select movie_id as v40 from aka_title as aka_t group by movie_id)
select id as v40, title as v41, production_year as v44 from title as t, aggView4936415334518579789 where t.id=aggView4936415334518579789.v40 and production_year>1990);
create or replace view aggJoin7088085379444795650 as (
with aggView7157811661225107872 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7157811661225107872 where mk.keyword_id=aggView7157811661225107872.v24);
create or replace view aggJoin1911899424217594014 as (
with aggView7608934864694588775 as (select id as v20 from company_type as ct)
select v40 from aggJoin4509346483149489820 join aggView7608934864694588775 using(v20));
create or replace view aggJoin2651047757285746840 as (
with aggView9063674516758122951 as (select v40 from aggJoin1911899424217594014 group by v40)
select v40 from aggJoin7088085379444795650 join aggView9063674516758122951 using(v40));
create or replace view aggJoin6112234095927191505 as (
with aggView7470961940179283011 as (select v40 from aggJoin2651047757285746840 group by v40)
select v40, v41, v44 from aggJoin9134558330641578811 join aggView7470961940179283011 using(v40));
create or replace view aggView1184063089649862596 as select v41, v40 from aggJoin6112234095927191505 group by v41,v40;
create or replace view aggJoin6037654080160339323 as (
with aggView1030095651163109654 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView1030095651163109654 where mi.info_type_id=aggView1030095651163109654.v22 and note LIKE '%internet%' and ((info LIKE 'USA:% 199%') OR (info LIKE 'USA:% 200%')));
create or replace view aggView8510088492117286333 as select v40, v35 from aggJoin6037654080160339323 group by v40,v35;
create or replace view aggJoin3785467752139470002 as (
with aggView597155928440808198 as (select v40, MIN(v41) as v53 from aggView1184063089649862596 group by v40)
select v35, v53 from aggView8510088492117286333 join aggView597155928440808198 using(v40));
select MIN(v35) as v52,MIN(v53) as v53 from aggJoin3785467752139470002;
