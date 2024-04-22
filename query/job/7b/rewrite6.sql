create or replace view aggJoin3841469120376416382 as (
with aggView3762242192349825327 as (select id as v38, title as v51 from title as t where production_year<=1984 and production_year>=1980)
select linked_movie_id as v38, link_type_id as v18, v51 from movie_link as ml, aggView3762242192349825327 where ml.linked_movie_id=aggView3762242192349825327.v38);
create or replace view aggJoin5365098857149465979 as (
with aggView2811570511155912211 as (select id as v16 from info_type as it where info= 'mini biography')
select person_id as v24, note as v37 from person_info as pi, aggView2811570511155912211 where pi.info_type_id=aggView2811570511155912211.v16 and note= 'Volker Boehm');
create or replace view aggJoin7570350155103581233 as (
with aggView4865526551068961748 as (select id as v18 from link_type as lt where link= 'features')
select v38, v51 from aggJoin3841469120376416382 join aggView4865526551068961748 using(v18));
create or replace view aggJoin8985566083461326311 as (
with aggView1342724595756229817 as (select v38, MIN(v51) as v51 from aggJoin7570350155103581233 group by v38,v51)
select person_id as v24, v51 from cast_info as ci, aggView1342724595756229817 where ci.movie_id=aggView1342724595756229817.v38);
create or replace view aggJoin6280144819555278703 as (
with aggView3690275232587467485 as (select person_id as v24 from aka_name as an where name LIKE '%a%' group by person_id)
select v24, v37 from aggJoin5365098857149465979 join aggView3690275232587467485 using(v24));
create or replace view aggJoin8503580664914424747 as (
with aggView6892230432194922325 as (select v24 from aggJoin6280144819555278703 group by v24)
select id as v24, name as v25, gender as v28, name_pcode_cf as v29 from name as n, aggView6892230432194922325 where n.id=aggView6892230432194922325.v24 and gender= 'm' and name_pcode_cf LIKE 'D%');
create or replace view aggJoin2663441779784216457 as (
with aggView8022159628450360105 as (select v24, MIN(v25) as v50 from aggJoin8503580664914424747 group by v24)
select v51 as v51, v50 from aggJoin8985566083461326311 join aggView8022159628450360105 using(v24));
select MIN(v50) as v50,MIN(v51) as v51 from aggJoin2663441779784216457;
