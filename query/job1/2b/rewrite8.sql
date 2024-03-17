create or replace view aggView2315392465644491505 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3692563030691843165 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2315392465644491505 where mk.movie_id=aggView2315392465644491505.v12;
create or replace view aggView8269663671272874159 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin7618063406720842638 as select movie_id as v12 from movie_companies as mc, aggView8269663671272874159 where mc.company_id=aggView8269663671272874159.v1;
create or replace view aggView5615071473516870434 as select v12 from aggJoin7618063406720842638 group by v12;
create or replace view aggJoin7465163270292284342 as select v18, v31 as v31 from aggJoin3692563030691843165 join aggView5615071473516870434 using(v12);
create or replace view aggView1042671767366991259 as select v18, MIN(v31) as v31 from aggJoin7465163270292284342 group by v18;
create or replace view aggJoin2631568193541056463 as select keyword as v9, v31 from keyword as k, aggView1042671767366991259 where k.id=aggView1042671767366991259.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin2631568193541056463;
