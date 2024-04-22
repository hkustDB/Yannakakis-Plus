create or replace view aggJoin6100023364211742045 as (
with aggView7013955522089762326 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView7013955522089762326 where mc.company_type_id=aggView7013955522089762326.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%');
create or replace view aggJoin5897670038905150427 as (
with aggView7645415718623500964 as (select v15 from aggJoin6100023364211742045 group by v15)
select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView7645415718623500964 where mi.movie_id=aggView7645415718623500964.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin6228840713413743619 as (
with aggView3125862527719943736 as (select id as v3 from info_type as it)
select v15, v13 from aggJoin5897670038905150427 join aggView3125862527719943736 using(v3));
create or replace view aggJoin5756799119137943360 as (
with aggView3469950425639596578 as (select v15 from aggJoin6228840713413743619 group by v15)
select title as v16 from title as t, aggView3469950425639596578 where t.id=aggView3469950425639596578.v15 and production_year>2005);
select MIN(v16) as v27 from aggJoin5756799119137943360;
