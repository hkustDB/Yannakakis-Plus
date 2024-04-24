create or replace view aggView5783630465731385564 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2856388299140734245 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5783630465731385564 where mi_idx.info_type_id=aggView5783630465731385564.v3;
create or replace view aggView3804655594352958890 as select v15 from aggJoin2856388299140734245 group by v15;
create or replace view aggJoin7862628164935502790 as select id as v15, title as v16, production_year as v19 from title as t, aggView3804655594352958890 where t.id=aggView3804655594352958890.v15 and production_year>2000;
create or replace view aggView1889242204527145624 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin7862628164935502790 group by v15;
create or replace view aggJoin2164954250241780136 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1889242204527145624 where mc.movie_id=aggView1889242204527145624.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3781016153066041564 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5795075906959446907 as select v9, v28, v29 from aggJoin2164954250241780136 join aggView3781016153066041564 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5795075906959446907;
