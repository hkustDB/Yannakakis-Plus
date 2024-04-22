create or replace view aggJoin1729596473472054696 as (
with aggView7879798416144983692 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView7879798416144983692 where mc.company_type_id=aggView7879798416144983692.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%');
create or replace view aggJoin8946757342453575545 as (
with aggView5387753071375321022 as (select v15 from aggJoin1729596473472054696 group by v15)
select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView5387753071375321022 where mi.movie_id=aggView5387753071375321022.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin4281066025803738855 as (
with aggView6802107983801664629 as (select id as v3 from info_type as it)
select v15, v13 from aggJoin8946757342453575545 join aggView6802107983801664629 using(v3));
create or replace view aggJoin6238461613320753664 as (
with aggView2953062688117760369 as (select v15 from aggJoin4281066025803738855 group by v15)
select title as v16 from title as t, aggView2953062688117760369 where t.id=aggView2953062688117760369.v15 and production_year>1990);
select MIN(v16) as v27 from aggJoin6238461613320753664;
