create or replace view aggView4759715993030413810 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7574458441360748437 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4759715993030413810 where mc.company_type_id=aggView4759715993030413810.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView6629114755008734673 as select v15 from aggJoin7574458441360748437 group by v15;
create or replace view aggJoin371308710617596581 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView6629114755008734673 where mi.movie_id=aggView6629114755008734673.v15 and info IN ('USA','America');
create or replace view aggView6761257025682280555 as select id as v3 from info_type as it;
create or replace view aggJoin3084062680236429391 as select v15, v13 from aggJoin371308710617596581 join aggView6761257025682280555 using(v3);
create or replace view aggView7104759467330981713 as select v15 from aggJoin3084062680236429391 group by v15;
create or replace view aggJoin5670285257921276350 as select title as v16 from title as t, aggView7104759467330981713 where t.id=aggView7104759467330981713.v15 and production_year>2010;
select MIN(v16) as v27 from aggJoin5670285257921276350;
