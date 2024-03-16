create or replace view aggView4041275905488866892 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6522160161567219714 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4041275905488866892 where mi_idx.info_type_id=aggView4041275905488866892.v3;
create or replace view aggView8928937546194702430 as select v15 from aggJoin6522160161567219714 group by v15;
create or replace view aggJoin3027327116836190663 as select id as v15, title as v16, production_year as v19 from title as t, aggView8928937546194702430 where t.id=aggView8928937546194702430.v15;
create or replace view aggView132995356616623710 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin3027327116836190663 group by v15;
create or replace view aggJoin6654071712913471375 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView132995356616623710 where mc.movie_id=aggView132995356616623710.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView8150188742925241050 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin6654071712913471375 group by v1;
create or replace view aggJoin449003685760446875 as select kind as v2, v28, v29, v27 from company_type as ct, aggView8150188742925241050 where ct.id=aggView8150188742925241050.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin449003685760446875;
