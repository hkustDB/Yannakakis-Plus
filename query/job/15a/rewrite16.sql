create or replace view aggJoin2731045465293521903 as (
with aggView5502347291080164513 as (select id as v40, title as v53 from title as t where production_year>2000)
select movie_id as v40, v53 from aka_title as aka_t, aggView5502347291080164513 where aka_t.movie_id=aggView5502347291080164513.v40);
create or replace view aggJoin587374005120934543 as (
with aggView7347215598363665744 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView7347215598363665744 where mk.keyword_id=aggView7347215598363665744.v24);
create or replace view aggJoin6643685486202870232 as (
with aggView8045954232955483182 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView8045954232955483182 where mc.company_id=aggView8045954232955483182.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin4418092401339376456 as (
with aggView1087516837628008322 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin6643685486202870232 join aggView1087516837628008322 using(v20));
create or replace view aggJoin1349998984480503492 as (
with aggView7469439073105821132 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, info as v35, note as v36 from movie_info as mi, aggView7469439073105821132 where mi.info_type_id=aggView7469439073105821132.v22 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin4775426339222948536 as (
with aggView6288022922419489523 as (select v40, MIN(v35) as v52 from aggJoin1349998984480503492 group by v40)
select v40, v53 as v53, v52 from aggJoin2731045465293521903 join aggView6288022922419489523 using(v40));
create or replace view aggJoin7507107899655374246 as (
with aggView3881123411396711088 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin4775426339222948536 group by v40,v53,v52)
select v40, v53, v52 from aggJoin587374005120934543 join aggView3881123411396711088 using(v40));
create or replace view aggJoin1488394736688176913 as (
with aggView3831301026958425125 as (select v40 from aggJoin4418092401339376456 group by v40)
select v53 as v53, v52 as v52 from aggJoin7507107899655374246 join aggView3831301026958425125 using(v40));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin1488394736688176913;
