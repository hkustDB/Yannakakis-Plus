create or replace view aggView7978229183751932003 as select id as v14, title as v27 from title as t where production_year>2005;
create or replace view aggJoin987018282907678559 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView7978229183751932003 where mi_idx.movie_id=aggView7978229183751932003.v14 and info>'5.0';
create or replace view aggView6451700629274158641 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5776631920972009000 as select v14, v9, v27 from aggJoin987018282907678559 join aggView6451700629274158641 using(v1);
create or replace view aggView458765971629985536 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6365953187608989841 as select movie_id as v14 from movie_keyword as mk, aggView458765971629985536 where mk.keyword_id=aggView458765971629985536.v3;
create or replace view aggView2152833153662267423 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin5776631920972009000 group by v14,v27;
create or replace view aggJoin2446699074445123261 as select v27, v26 from aggJoin6365953187608989841 join aggView2152833153662267423 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin2446699074445123261;
