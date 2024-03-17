create or replace view aggView5222603534667073269 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin2146661755463129024 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5222603534667073269 where mi_idx.info_type_id=aggView5222603534667073269.v3;
create or replace view aggView452285348935953922 as select v15 from aggJoin2146661755463129024 group by v15;
create or replace view aggJoin6173552907542878641 as select id as v15, title as v16, production_year as v19 from title as t, aggView452285348935953922 where t.id=aggView452285348935953922.v15;
create or replace view aggView2607559031223659575 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6173552907542878641 group by v15;
create or replace view aggJoin6502501258981925450 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2607559031223659575 where mc.movie_id=aggView2607559031223659575.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView6623783896084833939 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6502501258981925450 group by v1;
create or replace view aggJoin6102181182020807820 as select kind as v2, v28, v29, v27 from company_type as ct, aggView6623783896084833939 where ct.id=aggView6623783896084833939.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6102181182020807820;
