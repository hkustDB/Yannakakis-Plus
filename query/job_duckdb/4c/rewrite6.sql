create or replace view aggView7533204779405467783 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin971602053008664917 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView7533204779405467783 where mi_idx.info_type_id=aggView7533204779405467783.v1 and info>'2.0';
create or replace view aggView5829932379959100072 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin264618930721806963 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView5829932379959100072 where mk.movie_id=aggView5829932379959100072.v14;
create or replace view aggView6170640553627908458 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3023545653001057685 as select v14, v27 from aggJoin264618930721806963 join aggView6170640553627908458 using(v3);
create or replace view aggView5316626130934155302 as select v14, MIN(v9) as v26 from aggJoin971602053008664917 group by v14;
create or replace view aggJoin3053268988630277412 as select v27 as v27, v26 from aggJoin3023545653001057685 join aggView5316626130934155302 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3053268988630277412;
