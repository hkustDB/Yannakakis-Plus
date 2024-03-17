create or replace view aggView6449757253541482825 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin2008073204570513732 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView6449757253541482825 where mi_idx.movie_id=aggView6449757253541482825.v14 and info>'5.0';
create or replace view aggView2916369589953862880 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5232601470772374879 as select movie_id as v14 from movie_keyword as mk, aggView2916369589953862880 where mk.keyword_id=aggView2916369589953862880.v3;
create or replace view aggView636632183572747008 as select v14 from aggJoin5232601470772374879 group by v14;
create or replace view aggJoin4646909147837603517 as select v1, v9, v27 as v27 from aggJoin2008073204570513732 join aggView636632183572747008 using(v14);
create or replace view aggView594987682212070426 as select v1, MIN(v27) as v27, MIN(v9) as v26 from aggJoin4646909147837603517 group by v1;
create or replace view aggJoin1565350270422090995 as select v27, v26 from info_type as it, aggView594987682212070426 where it.id=aggView594987682212070426.v1 and info= 'rating';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1565350270422090995;
