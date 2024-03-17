create or replace view aggView4726318745121052773 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin2138130441521761932 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView4726318745121052773 where mi_idx.movie_id=aggView4726318745121052773.v14 and info>'5.0';
create or replace view aggView742591890787125025 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1239339198230133264 as select movie_id as v14 from movie_keyword as mk, aggView742591890787125025 where mk.keyword_id=aggView742591890787125025.v3;
create or replace view aggView7069232313262697246 as select v14 from aggJoin1239339198230133264 group by v14;
create or replace view aggJoin521327680523439735 as select v1, v9, v27 as v27 from aggJoin2138130441521761932 join aggView7069232313262697246 using(v14);
create or replace view aggView1771556624349230836 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin521327680523439735 group by v1;
create or replace view aggJoin4389804199643479783 as select v27, v26 from info_type as it, aggView1771556624349230836 where it.id=aggView1771556624349230836.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4389804199643479783;
