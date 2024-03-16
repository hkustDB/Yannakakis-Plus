create or replace view aggView2976548884824498730 as select id as v3 from info_type as it;
create or replace view aggJoin5073024270060268543 as select movie_id as v15, info as v13 from movie_info as mi, aggView2976548884824498730 where mi.info_type_id=aggView2976548884824498730.v3 and info IN ('USA','America');
create or replace view aggView9066922015189453981 as select v15 from aggJoin5073024270060268543 group by v15;
create or replace view aggJoin8505574110402780605 as select id as v15, title as v16 from title as t, aggView9066922015189453981 where t.id=aggView9066922015189453981.v15 and production_year>2010;
create or replace view aggView3326857058278956174 as select v15, MIN(v16) as v27 from aggJoin8505574110402780605 group by v15;
create or replace view aggJoin3407378928161226996 as select company_type_id as v1, v27 from movie_companies as mc, aggView3326857058278956174 where mc.movie_id=aggView3326857058278956174.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7297316351881461746 as select v1, MIN(v27) as v27 from aggJoin3407378928161226996 group by v1;
create or replace view aggJoin5696107936570598991 as select v27 from company_type as ct, aggView7297316351881461746 where ct.id=aggView7297316351881461746.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin5696107936570598991;
