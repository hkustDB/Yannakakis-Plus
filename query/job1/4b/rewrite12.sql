create or replace view aggView6802453753307900037 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2660237249993548186 as select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView6802453753307900037 where mk.movie_id=aggView6802453753307900037.v14;
create or replace view aggView8319981999845665642 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin7807401299769771079 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8319981999845665642 where mi_idx.info_type_id=aggView8319981999845665642.v1 and info>'9.0';
create or replace view aggView3911052135761472278 as select v14, MIN(v9) as v26 from aggJoin7807401299769771079 group by v14;
create or replace view aggJoin2304571242854366975 as select v3, v27 as v27, v26 from aggJoin2660237249993548186 join aggView3911052135761472278 using(v14);
create or replace view aggView3998517504089763585 as select v3, MIN(v27) as v27, MIN(v26) as v26 from aggJoin2304571242854366975 group by v3;
create or replace view aggJoin4475655493379457014 as select v27, v26 from keyword as k, aggView3998517504089763585 where k.id=aggView3998517504089763585.v3 and keyword LIKE '%sequel%';
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin4475655493379457014;
