create or replace view aggJoin2334885626920856037 as (
with aggView3669790946548225581 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView3669790946548225581 where mi_idx.info_type_id=aggView3669790946548225581.v3);
create or replace view aggJoin3592836267587853554 as (
with aggView2355446775305701050 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView2355446775305701050 where mk.keyword_id=aggView2355446775305701050.v5);
create or replace view aggJoin3466105432259010017 as (
with aggView1883730512631789705 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView1883730512631789705 where mi.info_type_id=aggView1883730512631789705.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin2895737480569416000 as (
with aggView474584528430472768 as (select v23 from aggJoin3592836267587853554 group by v23)
select v23, v13 from aggJoin3466105432259010017 join aggView474584528430472768 using(v23));
create or replace view aggJoin9016651585252247770 as (
with aggView6596022937055392672 as (select v23 from aggJoin2895737480569416000 group by v23)
select v23, v18 from aggJoin2334885626920856037 join aggView6596022937055392672 using(v23));
create or replace view aggJoin4540691665534493564 as (
with aggView8098168266561277717 as (select v23, v18 from aggJoin9016651585252247770 group by v23,v18)
select v23, v18 from aggView8098168266561277717 where v18<'8.5');
create or replace view aggJoin326057163721425153 as (
with aggView2679158387416166007 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView2679158387416166007 where t.kind_id=aggView2679158387416166007.v8 and production_year>2010);
create or replace view aggView3570671072009173587 as select v23, v24 from aggJoin326057163721425153 group by v23,v24;
create or replace view aggJoin5766719355308845178 as (
with aggView952472207856643776 as (select v23, MIN(v18) as v35 from aggJoin4540691665534493564 group by v23)
select v24, v35 from aggView3570671072009173587 join aggView952472207856643776 using(v23));
select MIN(v35) as v35,MIN(v24) as v36 from aggJoin5766719355308845178;
