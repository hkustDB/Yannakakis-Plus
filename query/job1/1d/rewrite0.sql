create or replace view aggView3733421590153009739 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7621826286751024267 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3733421590153009739 where mi_idx.info_type_id=aggView3733421590153009739.v3;
create or replace view aggView7623559210372309614 as select v15 from aggJoin7621826286751024267 group by v15;
create or replace view aggJoin5457128271507266055 as select id as v15, title as v16, production_year as v19 from title as t, aggView7623559210372309614 where t.id=aggView7623559210372309614.v15 and production_year>2000;
create or replace view aggView1831917142115459977 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5457128271507266055 group by v15;
create or replace view aggJoin2031002561916364961 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1831917142115459977 where mc.movie_id=aggView1831917142115459977.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5206523698356239847 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin2031002561916364961 group by v1;
create or replace view aggJoin2940643622515592467 as select v28, v29, v27 from company_type as ct, aggView5206523698356239847 where ct.id=aggView5206523698356239847.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2940643622515592467;
