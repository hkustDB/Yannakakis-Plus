create or replace view aggJoin4136488243747454835 as (
with aggView2154687513019729814 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, info as v36 from person_info as pi, aggView2154687513019729814 where pi.info_type_id=aggView2154687513019729814.v16);
create or replace view aggView4691361452171034420 as select v24, v36 from aggJoin4136488243747454835 group by v24,v36;
create or replace view aggJoin6222810668518570595 as (
with aggView7623883297312487794 as (select id as v38 from title as t where production_year<=2010 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18 from movie_link as ml, aggView7623883297312487794 where ml.linked_movie_id=aggView7623883297312487794.v38);
create or replace view aggJoin940810949285141756 as (
with aggView8259419145659444892 as (select id as v18 from link_type as lt where link IN ('references','referenced in','features','featured in'))
select v38 from aggJoin6222810668518570595 join aggView8259419145659444892 using(v18));
create or replace view aggJoin2103206013910791869 as (
with aggView1689886517492819344 as (select v38 from aggJoin940810949285141756 group by v38)
select person_id as v24 from cast_info as ci, aggView1689886517492819344 where ci.movie_id=aggView1689886517492819344.v38);
create or replace view aggJoin5360499630206378432 as (
with aggView3920615236809261752 as (select v24 from aggJoin2103206013910791869 group by v24)
select id as v24, name as v25, name_pcode_cf as v29 from name as n, aggView3920615236809261752 where n.id=aggView3920615236809261752.v24 and name_pcode_cf>='A' and name_pcode_cf<='F');
create or replace view aggJoin4166961893279741494 as (
with aggView7421175801207611694 as (select person_id as v24 from aka_name as an where ((name LIKE '%a%') OR (name LIKE 'A%')) group by person_id)
select v24, v25, v29 from aggJoin5360499630206378432 join aggView7421175801207611694 using(v24));
create or replace view aggJoin7564678596584599999 as (
with aggView1649001722379316498 as (select v25, v24 from aggJoin4166961893279741494 group by v25,v24)
select v24, v25 from aggView1649001722379316498 where v25 LIKE 'A%');
create or replace view aggJoin7580324273371316359 as (
with aggView1587328532056261116 as (select v24, MIN(v25) as v50 from aggJoin7564678596584599999 group by v24)
select v36, v50 from aggView4691361452171034420 join aggView1587328532056261116 using(v24));
select MIN(v50) as v50,MIN(v36) as v51 from aggJoin7580324273371316359;
