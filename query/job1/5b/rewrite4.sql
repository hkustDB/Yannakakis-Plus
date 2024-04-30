create or replace view aggView1977774606098587684 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin6628459715650900168 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView1977774606098587684 where mc.movie_id=aggView1977774606098587684.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7389345726857557965 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5973662570201530064 as select v15, v9, v27 from aggJoin6628459715650900168 join aggView7389345726857557965 using(v1);
create or replace view aggView9069176909494094557 as select v15, MIN(v27) as v27 from aggJoin5973662570201530064 group by v15;
create or replace view aggJoin9190040282892964920 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView9069176909494094557 where mi.movie_id=aggView9069176909494094557.v15 and info IN ('USA','America');
create or replace view aggView7103177328742457374 as select id as v3 from info_type as it;
create or replace view aggJoin7237937883693203865 as select v27 from aggJoin9190040282892964920 join aggView7103177328742457374 using(v3);
select MIN(v27) as v27 from aggJoin7237937883693203865;
