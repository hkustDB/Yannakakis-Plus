create or replace view aggJoin6355856894049617770 as (
with aggView3307574246113822691 as (select id as v40, title as v53 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v40, keyword_id as v24, v53 from movie_keyword as mk, aggView3307574246113822691 where mk.movie_id=aggView3307574246113822691.v40);
create or replace view aggJoin6279943867655322593 as (
with aggView7330477147951304027 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7330477147951304027 where mi.info_type_id=aggView7330477147951304027.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin5452553216826946804 as (
with aggView7268234040316987350 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView7268234040316987350 where mc.company_id=aggView7268234040316987350.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin3736281011764767975 as (
with aggView4899848241953890441 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin5452553216826946804 join aggView4899848241953890441 using(v20));
create or replace view aggJoin5091574721071903057 as (
with aggView1505746554754553365 as (select v40 from aggJoin3736281011764767975 group by v40)
select movie_id as v40 from aka_title as aka_t, aggView1505746554754553365 where aka_t.movie_id=aggView1505746554754553365.v40);
create or replace view aggJoin4194795742297027919 as (
with aggView360957159360547416 as (select v40 from aggJoin5091574721071903057 group by v40)
select v40, v35, v36 from aggJoin6279943867655322593 join aggView360957159360547416 using(v40));
create or replace view aggJoin3468201132708402069 as (
with aggView8983905547212265134 as (select v40, MIN(v35) as v52 from aggJoin4194795742297027919 group by v40)
select v24, v53 as v53, v52 from aggJoin6355856894049617770 join aggView8983905547212265134 using(v40));
create or replace view aggJoin1470319696808024278 as (
with aggView550370062443897522 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin3468201132708402069 join aggView550370062443897522 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1470319696808024278;
