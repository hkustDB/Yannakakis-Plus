create or replace view aggJoin2270833418718736996 as (
with aggView2361038951206770235 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView2361038951206770235 where mi_idx.info_type_id=aggView2361038951206770235.v3 and info<'8.5');
create or replace view aggJoin4060944854156650635 as (
with aggView4272458834298816059 as (select v23, MIN(v18) as v35 from aggJoin2270833418718736996 group by v23)
select id as v23, title as v24, kind_id as v8, production_year as v27, v35 from title as t, aggView4272458834298816059 where t.id=aggView4272458834298816059.v23 and production_year>2010);
create or replace view aggJoin4862842623878568044 as (
with aggView6613594754830508032 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView6613594754830508032 where mk.keyword_id=aggView6613594754830508032.v5);
create or replace view aggJoin5187799011717386280 as (
with aggView5359548126593301929 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView5359548126593301929 where mi.info_type_id=aggView5359548126593301929.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin9152302299455490553 as (
with aggView6162606070305946875 as (select v23 from aggJoin5187799011717386280 group by v23)
select v23 from aggJoin4862842623878568044 join aggView6162606070305946875 using(v23));
create or replace view aggJoin5152301632389111880 as (
with aggView758171989018570439 as (select id as v8 from kind_type as kt where kind= 'movie')
select v23, v24, v27, v35 from aggJoin4060944854156650635 join aggView758171989018570439 using(v8));
create or replace view aggJoin4667860770294335482 as (
with aggView4454637032859919401 as (select v23, MIN(v35) as v35, MIN(v24) as v36 from aggJoin5152301632389111880 group by v23,v35)
select v35, v36 from aggJoin9152302299455490553 join aggView4454637032859919401 using(v23));
select MIN(v35) as v35,MIN(v36) as v36 from aggJoin4667860770294335482;
