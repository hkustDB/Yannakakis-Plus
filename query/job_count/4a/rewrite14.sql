create or replace view aggView7909907349585440018 as select id as v14 from title as t where production_year>2005;
create or replace view aggJoin8984893679092608787 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx as mi_idx, aggView7909907349585440018 where mi_idx.movie_id=aggView7909907349585440018.v14 and info>'5.0';
create or replace view aggView5425131109290133242 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8840519930828268849 as select v14, v9 from aggJoin8984893679092608787 join aggView5425131109290133242 using(v1);
create or replace view aggView8453146955351832065 as select v14, COUNT(*) as annot from aggJoin8840519930828268849 group by v14;
create or replace view aggJoin3508953131380532424 as select keyword_id as v3, annot from movie_keyword as mk, aggView8453146955351832065 where mk.movie_id=aggView8453146955351832065.v14;
create or replace view aggView945179411442803769 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4764529926961323698 as select annot from aggJoin3508953131380532424 join aggView945179411442803769 using(v3);
select SUM(annot) as v26 from aggJoin4764529926961323698;
