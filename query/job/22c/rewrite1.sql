create or replace view aggView1982199985731972601 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin8983049229695480782 as (
with aggView975052809714273174 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView975052809714273174 where t.kind_id=aggView975052809714273174.v17 and production_year>2005);
create or replace view aggJoin3849309791050570761 as (
with aggView6179402934520357079 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView6179402934520357079 where mi_idx.info_type_id=aggView6179402934520357079.v12 and info<'8.5');
create or replace view aggView5423947285590899906 as select v37, v32 from aggJoin3849309791050570761 group by v37,v32;
create or replace view aggJoin8701110517892746775 as (
with aggView988291063816845383 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView988291063816845383 where mi.info_type_id=aggView988291063816845383.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin5750253071975056866 as (
with aggView7772358985694814482 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView7772358985694814482 where mk.keyword_id=aggView7772358985694814482.v14);
create or replace view aggJoin7280590882330274992 as (
with aggView406606993471970326 as (select v37 from aggJoin5750253071975056866 group by v37)
select v37, v38, v41 from aggJoin8983049229695480782 join aggView406606993471970326 using(v37));
create or replace view aggJoin8162558449001115786 as (
with aggView3065567517730730161 as (select v37 from aggJoin8701110517892746775 group by v37)
select v37, v38, v41 from aggJoin7280590882330274992 join aggView3065567517730730161 using(v37));
create or replace view aggView7305850460070821253 as select v38, v37 from aggJoin8162558449001115786 group by v38,v37;
create or replace view aggJoin8079593973675692353 as (
with aggView3476210534127664284 as (select v37, MIN(v38) as v51 from aggView7305850460070821253 group by v37)
select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v51 from movie_companies as mc, aggView3476210534127664284 where mc.movie_id=aggView3476210534127664284.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1462977334343887004 as (
with aggView2830208973210224641 as (select v1, MIN(v2) as v49 from aggView1982199985731972601 group by v1)
select v37, v8, v23, v51 as v51, v49 from aggJoin8079593973675692353 join aggView2830208973210224641 using(v1));
create or replace view aggJoin1708954445232724588 as (
with aggView4829492820777364696 as (select id as v8 from company_type as ct)
select v37, v23, v51, v49 from aggJoin1462977334343887004 join aggView4829492820777364696 using(v8));
create or replace view aggJoin3602298073219826722 as (
with aggView8695129459416207147 as (select v37, MIN(v51) as v51, MIN(v49) as v49 from aggJoin1708954445232724588 group by v37,v49,v51)
select v32, v51, v49 from aggView5423947285590899906 join aggView8695129459416207147 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin3602298073219826722;
