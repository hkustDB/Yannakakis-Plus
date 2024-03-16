create or replace view aggView999847094766726766 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin1515456954389665010 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView999847094766726766 where mk.movie_id=aggView999847094766726766.v14;
create or replace view aggView7275404374626637636 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4206489064793436405 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7275404374626637636 where mi_idx.info_type_id=aggView7275404374626637636.v1 and info>'5.0';
create or replace view aggView4351553927315814640 as select v14, MIN(v9) as v26 from aggJoin4206489064793436405 group by v14;
create or replace view aggJoin475760564290575984 as select v3, v27 as v27, v26 from aggJoin1515456954389665010 join aggView4351553927315814640 using(v14);
create or replace view aggView4603316606233620686 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin475760564290575984 group by v3;
create or replace view aggJoin1276609794596725678 as select v27, v26 from keyword as k, aggView4603316606233620686 where k.id=aggView4603316606233620686.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1276609794596725678;
